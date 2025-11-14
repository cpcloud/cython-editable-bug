# Reproducible example for Cython editable install bug

## Steps

### Install `pixi`

```
curl -fsSL https://pixi.sh/install.sh | sh
```

### Build the dependency package, `deppkg`

This must be installed in editable mode.

```
# make sure nothing is lingering in the environment
git clean -fdx

cd deppkg
pixi run pip install --editable .
```

### Verify that `deppkg` is importable

```
pixi run python -c 'import deppkg'
```

### Try to build the main package, `mainpkg`

```
cd ../mainpkg

# this should fail to find `deppkg/test.pxd` even though deppkg is installed and importable
#
# --no-build-isolation is there to match the arguments below
pixi run pip install . --no-build-isolation
```

### Installing `deppkg` without `--editable` allows `mainpkg` to build successfully

```
cd ..
git clean -fdx

cd ./deppkg

pixi run pip uninstall -y mainpkg deppkg
pixi run pip install .

cd ../mainpkg
# --no-build-isolation is necessary because `deppkg` is a build dependency
# and of course not available on pypi
pixi run pip install . --no-build-isolation
```
