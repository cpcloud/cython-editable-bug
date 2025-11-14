# Reproducible example for Cython editable install bug

## Steps

### Install `pixi`

```
curl -fsSL https://pixi.sh/install.sh | sh
```

### Build the dependency package, `deppkg`

This must be installed in editable mode.

```
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
pixi run pip install .
```

### Installing `deppkg` without `--editable` allows `mainpkg` to build successfully

```
cd ..
git clean -fdx

cd ./deppkg

pixi run pip uninstall -y mainpkg deppkg
pixi run pip install .

cd ../mainpkg
pixi run pip install .
```
