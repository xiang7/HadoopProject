T="$(date +%s)"
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0/
./mahout-distribution-0.7/bin/mahout seqdirectory \
    -i ./test_mahout/docs/ \
    -o ./test_mahout/sequenced
./mahout-distribution-0.7/bin/mahout seq2sparse \
    -i ./test_mahout/sequenced \
    -o ./test_mahout/sparseVectors \
    --namedVector \
    -wt tf
./mahout-distribution-0.7/bin/mahout rowid \
    -i ./test_mahout/sparseVectors/tf-vectors/ \
    -o ./test_mahout/matrix
./mahout-distribution-0.7/bin/mahout cvb \
    -i ./test_mahout/matrix/matrix \
    -dict ./test_mahout/sparseVectors/dictionary.file-0 \
    -a 0.01 \
    -e 5 \
    -k 10 \
    -o ./test_mahout/cvb/to_out \
    --maxIter 1
./mahout-distribution-0.7/bin/mahout vectordump \
    -i ./test_mahout/cvb/to_out \
    --dictionary ./test_mahout/sparseVectors/dictionary.file-0 \
    --dictionaryType sequencefile \
    > result
python get_top_k.py
T="$(($(date +%s)-T))"
echo "Time elasped in seconds: ${T}"
