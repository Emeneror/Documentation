# Documentation


This Sphinx theme documentation is set to harbor various projects informations.
It is based on the ReadTheDocs Theme


# Install

```sh
sudo pip install sphinx_rtd_theme
# git clone the project
```

# Run the build

- Go to `<your_path>/documentation/Sphinx`
- Do `./compile.sh --html` to build Web documentation.
- Do `./compile.sh --latexpdf` to build PDF documentation.


# Documentation syntax 

read the docs manual : https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html



# Container version for NAS

Link : https://hub.docker.com/r/ddidier/sphinx-doc/#introduction

TL;DR : 

```shell script
docker pull ddidier/sphinx-doc
UID=0                           # 1026=Emeneror KO; 0=root OK.

# -----------------------------------------------------------------------------------------------------------
# Container is present on the machine.
#

# Install and compile
# HOST_DATA_DIR - alt : -v $(pwd):/doc
docker run -it -v <HOST_DATA_DIR>:/doc -e USER_ID=$UID ddidier/sphinx-doc sphinx-init --project my-documentation
docker run -i -v <HOST_DATA_DIR>:/doc -e USER_ID=$UID ddidier/sphinx-doc make html
```