
def find_value_from_key(input_object, keylist):
    for i in range(len(keylist)-1):
        input_object.update(input_object[keylist[i]])
        input_object.pop(keylist[i])
    return input_object

# Starting point of script

### Inputs

# object = {"a":{"b":{"c":"d"}}}
# key = "a/b/c"

object = {"x":{"y":{"z":"a"}}}
key = "x/y/z"


key_list = key.split("/")
result=find_value_from_key(object, key_list)
print(*result.values())



 



