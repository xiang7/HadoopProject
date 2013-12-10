T="$(date +%s)"
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0/
../mahout-distribution-0.7/bin/mahout seqdirectory \
    -i ./test_mahout/docs/ \
    -o ./test_mahout/sequenced
../mahout-distribution-0.7/bin/mahout seq2sparse \
    -i ./test_mahout/sequenced \
    -o ./test_mahout/sparseVectors \
    --namedVector \
    -wt tf
../mahout-distribution-0.7/bin/mahout rowid \
    -i ./test_mahout/sparseVectors/tf-vectors/ \
    -o ./test_mahout/matrix
../mahout-distribution-0.7/bin/mahout cvb0_local \
    -i ./test_mahout/matrix/matrix \
    -d ./test_mahout/sparseVectors/dictionary.file-0 \
    -a 0.1 \
    -top 10 \
    -do ./test_mahout/cvb/do_out \
    -to ./test_mahout/cvb/to_out \
    -m 1
../mahout-distribution-0.7/bin/mahout vectordump \
    -i ./test_mahout/cvb/to_out \
    --dictionary ./test_mahout/sparseVectors/dictionary.file-0 \
    --dictionaryType sequencefile \
    --vectorSize 10 > result
python get_top_k.py
T="$(($(date +%s)-T))"
echo "Time elasped in seconds: ${T}"