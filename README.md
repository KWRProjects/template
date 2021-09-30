ProjectName

# Datasets

## image

```markdown
![alt text](./sub%20folder/image.jpg)
```

## matplotlib

```python
# row: 3
# col: 2
# axs[0, 0] to axs[2, 1]
fig, axs = plt.subplots(3, 2, figsize=(15, 7))

# row: 1
# col: 1
fig, ax = plt.subplots(figsize=(15, 7))

# set layout, save and close figure
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.savefig()
plt.close()
```
