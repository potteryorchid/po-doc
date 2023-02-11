# Python

==============================================================================

## python
    # run library module as a script
    python -m

==============================================================================

## pip
    # pip install
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python get-pip.py

    # check version
    python -m pip --version

    # pip upgrade
    python -m pip install --upgrade pip

### how to use pip

python -m pip executes pip using the Python interpreter you specified as python. So /usr/bin/python3.7 -m pip means you are executing pip for your interpreter located at /usr/bin/python3.7.

    python -m pip <pip arguments>

### common cmd
    # list
    python -m pip list

    # install other tools by pip
    python -m pip install SomePackage
    python -m pip install SomePackage==1.0.4     # specific version
    python -m pip install 'SomePackage>=1.0.4'     # minimum version

Requirements files are used to hold the result from pip freeze for the purpose of achieving repeatable installations. In this case, your requirement file contains a pinned version of everything that was installed when pip freeze was run.

    python -m pip freeze > requirements.txt
    python -m pip install -r requirements.txt

    # uninstall
    python -m pip uninstall simplejson
    # Don’t ask for confirmation of uninstall deletions.
    python -m pip uninstall --yes simplejson
==============================================================================

## virtualenv
    #linux & mac
    pip install -U virtualenv
    virtualenv --system-site-packages -p python ./py2
    # start virtualenv
    source ./venv/bin/activate

    #window
    pip install -U virtualenv
    cd E:env
    virtualenv --system-site-packages -p python envname
    cd envname
    #进入envname/Scripts
    cd Scripts
    activate  # 启动虚拟环境
    deactivate # 退出虚拟环境

==============================================================================

## tensorflow
    pip install --upgrade tensorflow==1.12.0
    pip3 install --user --upgrade tensorflow

==============================================================================

## jupyterlab
    # install
    pip install jupyterlab

    # run
    jupyter-lab

==============================================================================

## jupyter
    pip install jupyter
    python -m ipykernel install --user --name=py2

    #list kernel
    jupyter kernelspec list

    #remove kernel
    jupyter kernelspec remove kernelname

    #open notebook
    jupyter notebook
    jupyter notebook --port <port number>   #指定端口
    jupyter notebook --no-browser   # 启动服务器但不在浏览器中打开

    #jupyter notebook config
    jupyter notebook --generate-config # path:/Users/po/.jupyter/jupyter_notebook_config.py

    #jupyter_notebook_config.py文件，第261行修改文件目录

    #config password
    from IPython.lib import passwd
    passwd()
    exit()

==============================================================================

## jupyter notebook

    # import images method 1, 图片文件要在notebook文件目录下
    ![neural](./imgs/neural.png)

    # import images method 2, python code
    from IPython.display import Image
    Image(filename="img/python.png", width=400, height=400)

    # import images method 3, makedown, center
    %%html<img src="img/python.png", width=400, height=400>

    # import images method 3, code, no center
    %%html<img src="img/python.png", width=400, height=400>

## docker tensorflow
    docker pull tensorflow/tensorflow:nightly-jupyter

==============================================================================

## mkdocs
    # install mkdocs
    python3 -m pip install mkdocs
    # install mkdocs plugins
    python3 -m pip install markdown_extensions_name

    # create new project
    mkdocs new my-project

    # run server
    mkdocs serve
    # run server with ip:port
    mkdocs serve -a localhost:8001

    # build
    mkdocs build
    # clean
    mkdocs build --clean

==============================================================================

## python uninstall
    1. python3 --version
    
    2. 
    cd /Library/Frameworks/Python.framework/Versions/
    rm -rf 3.8

    cd /Applications
    rm -rf Python\ 3.8/

    cd /usr/local/bin
    ls -ahl | grep py
    rm pydoc3 pydoc3.8 python3 python3-config python3.8 python3.8-config

    3. $ vi ~/.bash_profile