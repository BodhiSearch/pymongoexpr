import sys
from pathlib import Path

import toml

DOCS_DIR = Path(__file__).parent.absolute()
PROJ_DIR = DOCS_DIR / ".."
SRC_DIR = PROJ_DIR / "src"
sys.path.insert(0, str(SRC_DIR.resolve()))
with open(PROJ_DIR / "pyproject.toml") as f:
    pyproj_file = toml.load(f)

project = "pymongoexpr"
copyright = "2023, Amir Nagri"
author = "Amir Nagri"
release = pyproj_file["tool"]["poetry"]["version"]

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.napoleon",
    "sphinx.ext.intersphinx",
    "sphinx_copybutton",
    "sphinx_rtd_theme",
]
templates_path = ["_templates"]
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]

html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
intersphinx_mapping = {
    "python": ("https://docs.python.org/", None),
}
