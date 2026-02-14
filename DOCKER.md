```bash
docker run --rm -v "$PWD:/src" returntocorp/semgrep semgrep --config p/solidity --error --metrics=off /src
```