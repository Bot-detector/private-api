
# setup
## windows
```sh
python -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```
## linux
```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

```sh
.venv\Scripts\activate
pip freeze > requirements.txt
```

### tips linux / wsl
to open vscode in wsl just open vs code, type `wsl` in the terminal than type `code .`

tip: you can trim your command line path with
```sh
nano ~/.bashrc
```
add at the botom, exit nano with ctrl + x then press y to save
```sh
PROMPT_DIRTRIM=3
```

# kubectl
```sh
kubectl port-forward -n kafka svc/bd-prd-kafka-service 9094:9094
kubectl port-forward -n database svc/mysql 3306:3306
```
