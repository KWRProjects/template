# Docker

```shell
docker images
docker rmi
docker system prune -f

cd OneDrive/MSOD2work/20210201-KWR/02-Projects/99_Github-template
docker build --no-cache -t kwrprojects/devops:latest -f ./ci/devops-latest.Dockerfile .
docker build --no-cache -t kwrprojects/d3d:6_04_00_69364 -f ./ci/d3d-6_04_00_69364.Dockerfile .

docker push kwrprojects/devops:latest
docker push kwrprojects/d3d:6_04_00_69364

docker volume create d3d
```

```shell
docker system prune -f
docker run -it -w /DockerShare --name d3d --memory="10g" --cpuset-cpus="0-9" --volume="//d/DockerShare:/DockerShare" kwrprojects/d3d:6_04_00_69364

docker exec -it bf0f58ea0e51 bash
```

## cmake

```shell
/DockerShare/DevOps/cmake-3.21.3-linux-x86_64/bin/cmake ..
/DockerShare/DevOps/cmake-3.21.3-linux-x86_64/bin/cmake --build . --config Release
```

# gdb

```shell
gdb runepanetmsx
r EPA-Almere_3108_72h.inp MSX-Almere_3108_72h.msx MSX-Almere_3108_72h.rpt MSX-Almere_3108_72h.bin

backtrace
```

## python3.8

```shell
yum -y install openssl-devel bzip2-devel libffi-devel xz-devel
yum -y install wget

cd /root/Software
wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz
tar xvf /root/Software/Python-3.8.9.tgz
rm -f /root/Software/Python-3.8.9.tgz
cd /root/Software/Python-3.8.9
./configure --enable-optimizations
make altinstall
```

# build-essentials

```shell
yum groupinstall -y "Development Tools"
```

# git

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

# Python

## Virtual environment

Conda install at **C:\Anaconda3**.

```shell
conda config --add channels conda-forge
```
### Create env

**.condarc**
* $HOME\.condarc
* C:\Users\quanp\.condarc

```yaml
ssl_verify: true
channels:
  - conda-forge
  - defaults
envs_dirs:
  - C:\Anaconda3\envs
```

optional

```yaml
pkgs_dirs:
  - C:\Anaconda3\pkgs
```

**cmd**

```shell
conda env create -f environment.yml

conda env list
```

### Activate env

```shell
conda activate projectname

conda config --add channels conda-forge
```

### Install env

```shell
pip install -r requirements.txt

conda install Package

pip install Package
```

### Export env

```shell
conda env export > environment.yml
conda env export --no-builds -f environment.yml

pip freeze > requirements.txt
pip list --format=freeze > requirements.txt
```

### Update env

[pip update env](https://stackoverflow.com/questions/24764549/upgrade-python-packages-from-requirements-txt-using-pip-command)

```shell
conda env update --file environment.yml

pip install --upgrade --force-reinstall -r requirements.txt
pip install --ignore-installed -r requirements.txt
```

### Deactivate env

```shell
conda deactivate

conda env remove --name projectname
```

## matplotlib

```python
# https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.subplots.html

# row: 3
# col: 2
# axs[0, 0] to axs[2, 1]
fig, axs = plt.subplots(3, 2, figsize=(15, 7), num=1, clear=True)

axs[0, 0].plot(pltx, plty)
axs[1, 1].scatter(pltx, plty)

# row: 1
# col: 1
fig, ax = plt.subplots(figsize=(15, 7), num=1, clear=True)

ax.plot(pltx, plty,
        label=rpt_diff_type, linestyle='dashed',
        color='black', alpha=0.5, lw=0.5)

# set layout, save and close figure
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.grid(linewidth=0.5, zorder=-1)
plt.legend(loc='lower center', bbox_to_anchor=(0.2, -0.22, 0.6, 0.2),
           mode='expand', ncol=10, prop={'size': 6})
fig.subplots_adjust(bottom=0.2)
# plt.show()
plt.savefig(figname, dpi=600)
plt.close(fig)
plt.cla()
plt.clf()
```
