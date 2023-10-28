import os
import re
from pathlib import Path

import requests

HTML_PLUS = "%2B"


def normalize_pep_503(name):
    return re.sub(r"[-_.]+", "-", name).lower()


def get_packages_dict(links_wheels):
    packages = {}
    for link_wheel in links_wheels:
        file_name = link_wheel.split("/")[-1]
        package_and_version = file_name.split(HTML_PLUS)[0]
        package, _version = package_and_version.rsplit("-", 1)

        try:
            packages[package].append(link_wheel)
        except KeyError:
            packages[package] = [link_wheel]

    return packages


def get_links(releases):
    links = []
    for release in releases.json():
        release_links = (x["browser_download_url"] for x in release["assets"])
        links.extend(release_links)

    return links


def create_main_index(packages, output_file):
    with open(output_file, "w") as f:
        f.write('<!DOCTYPE html><html><head><meta name="pypi:repository-version" content="1.1"></head><body>\n')

        for package in packages:
            f.write(f'<a href="{normalize_pep_503(package)}/">{package}</a><br>\n')

        f.write("</body></html>")


def create_package_index(links_wheels, output_file):
    with open(output_file, "w") as f:
        f.write('<!DOCTYPE html><html><head><meta name="pypi:repository-version" content="1.1"></head><body>\n')

        file_names = set()
        for link_wheel in links_wheels:
            file_name = link_wheel.rsplit("/", 1)[1].replace(HTML_PLUS, "+")
            if file_name not in file_names:
                file_names.add(file_name)
                f.write(f'<a href="{link_wheel}">{file_name}</a><br>\n')

        f.write("</body></html>")


def create_pep_503_index(packages_dict, output_dir: Path):
    packages = sorted(packages_dict.keys(), key=str.lower)

    create_main_index(packages, output_dir / "index.html")

    for package in packages:
        package_dir = output_dir / normalize_pep_503(package)
        package_dir.mkdir()
        create_package_index(packages_dict[package], package_dir / "index.html")


def main():
    github_token = os.environ["GITHUB_TOKEN"]
    repository = os.environ["REPO_NAME"]
    output_dir = Path("_site")

    headers = {"Authorization": "token " + github_token}
    releases = requests.get(f"https://api.github.com/repos/{repository}/releases", headers=headers)

    links = get_links(releases)
    links_wheels = [x for x in links if x.endswith(".whl")]
    packages_dict = get_packages_dict(links_wheels)

    output_dir.mkdir()
    create_pep_503_index(packages_dict, output_dir)


if __name__ == "__main__":
    main()
