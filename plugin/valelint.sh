 #!/usr/bin/env bash

docker run -i --rm -v "$(pwd):/home/valeuser" bin/vale "$@"
