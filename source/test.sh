 #!/bin/bash

 set -e

 MIVAR=""

: ${MIVAR:="VALOR"}

# MIVAR=${MIVAR:="VALOR"}

 echo "Resultado: ${MIVAR-"OTRO"}"
