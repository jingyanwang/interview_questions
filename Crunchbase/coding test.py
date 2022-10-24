from typing import Any
import json

# Here at Crunchbase we track all click events users make and send them to Kafka in JSON format. That data is then consumed, transformed, and loaded into our data warehouse.

# First, we want to flatten each message and get rid of the nested json structure. Please use an underscore to combine the property names, as shown in the example:


'''

# We want you to convert
"""
{
  "a":"b",
  "c": {
    "d":"f"
  }
}
"""
# to
"""
{
  "a": "b",
  "c_d": "f"
}
"""

'''

input_example = {
  "a":"b",
  "c": {
    "d":"f"
  }
}



#print(input_example)

'''
recursive algorihm 
'''

def flatten_util(
    input_dict,
    current_key = None,
    ):

    '''
    corner case
    '''
    if type(input_dict) == str:
        return input_dict
   
    '''
    general case
    '''
    output_dict = {}

    for k in input_dict.keys():
        child_dict = flatten_util(
            input_dict[k],
            k,
        )
        
        pre_key = '' if current_key is None else current_key+"_"

        output_dict[pre_key] = child_dict
    
    return str(output_dict)


'''
test of the util 
'''

# test case 1 - corncer case

#print(flatten_util("a"))

input_example = {
  "c": {
    "d":"f"
  }
}

print(flatten_util(input_example))


input_str = """
{
  "a":"b",
  "c": {
    "d":"f"
  }
}
"""


'''
output = flatten_util(
    json.loads(input_str)
)

print(output)
'''

#print(output)


# print(json.loads("""{"a":"b"}"""))


# Fill in this function to "flatten" an input string
def flatten(input_str: str) -> dict[str, Any]:
    input_dict = json.loads(input_str)

    output_dict = {}

    for k in input_dict:
        output_dict[k] = flatten_util(input_dict[k])    

    return output_dict

'''

output_dict = flatten(input_str)

print(output_dict)

for k in output_dict:
    print(f'key:{k}, value:{output_dict[k]}')


'''