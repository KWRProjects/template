# ProjectName

## DevOps
### git

```shell
git clone --recurse-submodules -j8 https://github.com/KWRProjects/ProjectName.git

git submodule add https://github.com/KWRProjects/SIM_WDN-WNTR.git tool/simulation/wntr

git submodule update --remote tool/simulation/wntr
```

To remove a submodule `git rm -r tool/simulation/wntr`

- Delete the relevant section from the .gitmodules file.
- Stage the .gitmodules changes git add .gitmodules
- Delete the relevant section from .git/config.
- Run git rm --cached path_to_submodule (no trailing slash).
- Run rm -rf .git/modules/path_to_submodule (no trailing slash).
- Commit git commit -m "Removed submodule <name>"
- Delete the now untracked submodule files rm -rf path_to_submodule

### Virtual environment

```shell
conda config --add channels conda-forge
```
#### Create env

**.condarc**
* $HOME\.condarc
* C:\Users\quanp\.condarc

```yaml
ssl_verify: true
channels:
  - conda-forge
  - defaults
envs_dirs:
  - C:\ProgramData\Anaconda3\envs
```

optional

```yaml
pkgs_dirs:
  - C:\ProgramData\Anaconda3\pkgs
```

**cmd**

```shell
conda env create -f environment.yml

conda env list
```shell
```

#### Activate env

```shell
conda activate smartwaternetwork

conda config --add channels conda-forge
```

#### Install env

```shell
pip install -r requirements.txt

conda install Package

pip install Package
```

#### Export env

```shell
conda env export > environment.yml
conda env export --no-builds -f environment.yml

pip freeze > requirements.txt
pip list --format=freeze > requirements.txt
```

#### Update env

[pip update env](https://stackoverflow.com/questions/24764549/upgrade-python-packages-from-requirements-txt-using-pip-command)

```shell
conda env update --file environment.yml

pip install --upgrade --force-reinstall -r requirements.txt
pip install --ignore-installed -r requirements.txt
```

#### Deactivate env

```shell
conda deactivate

conda env remove --name smartwaternetwork
```

## Submodules

## Datasets

# Template

## shell

```shell

```

## image

```markdown
![alt text](./sub%20folder/image.jpg)
```
