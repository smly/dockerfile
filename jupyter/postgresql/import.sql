CREATE TABLE ItemPairs_train(itemID_1 int, itemID_2 int, isDuplicate int, generationMethod int);
CREATE TABLE ItemPairs_test(id int, itemID_1 int, itemID_2 int);

COPY ItemPairs_train(itemID_1, itemID_2, isDuplicate, generationMethod) FROM '/mnt/avito_dup/input/ItemPairs_train.csv' CSV HEADER;
COPY ItemPairs_test(id, itemID_1, itemID_2) FROM '/mnt/avito_dup/input/ItemPairs_test.csv' CSV HEADER;
