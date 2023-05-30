function getValueFromNestedObject(obj, key) {
    const keys = key.split('/');
    let value = obj;
  
    for (const k of keys) {
      if (typeof value === 'object' && value !== null && k in value) {
        value = value[k];
      } else {
        return undefined;
      }
    }
  
    return value;
  }
  
  // Example usage
  const object1 = { a: { b: { c: 'd' } } };
  const key1 = 'a/b/c';
  const value1 = getValueFromNestedObject(object1, key1);
  console.log(value1); // Output: d
  
  const object2 = { x: { y: { z: 'a' } } };
  const key2 = 'x/y/z';
  const value2 = getValueFromNestedObject(object2, key2);
  console.log(value2); // Output: a
  