def find_unique_elements(input_list):
    unique_list = []
    element_count = {}

    for item in input_list:
        if item in element_count:
            element_count[item] += 1
        else:
            element_count[item] = 1

    for item, count in element_count.items():
        if count == 1:
            unique_list.append(item)

    return unique_list

# Example usage:
input_list = [1, 2, 3, 2, 4, 5, 6, 4, 7, 8, 1]
unique_elements = find_unique_elements(input_list)
print("Input List:", input_list)
print("Unique Elements:", unique_elements)
