
rm -rf operations_research/linear_solver.proto
rm -rf operations_research/optional_boolean.proto

printf "\nGetting ortools/linear_solver/linear_solver.proto ....\n\n"
wget -q -P operations_research https://raw.githubusercontent.com/google/or-tools/v7.8/ortools/linear_solver/linear_solver.proto 

printf "Modifying ortools/linear_solver/linear_solver.proto with GO Language option ....\n\n"
sed '/^option/d' operations_research/linear_solver.proto | sed '/^import/d' | sed '32 i\option go_package="operations_research;operations_research";' | sed '35 i\import "optional_boolean.proto";'> operations_research/tmp
rm -f operations_research/linear_solver.proto
mv operations_research/tmp operations_research/linear_solver.proto 

printf "Getting ortools/util/optional_boolean.proto ....\n\n"
wget -q -P operations_research https://raw.githubusercontent.com/google/or-tools/v7.8/ortools/util/optional_boolean.proto 

printf "Modifyingortools/util/optional_boolean.proto with GO Language option ....\n\n"
sed '/^option/d' operations_research/optional_boolean.proto | sed '16 i\option go_package="operations_research;operations_research";' > operations_research/tmp
rm -f operations_research/optional_boolean.proto 
mv operations_research/tmp operations_research/optional_boolean.proto 

