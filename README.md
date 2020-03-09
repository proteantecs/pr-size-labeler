

## 🚀 Usage

Create a file named `labeler.yml` inside the `.github/workflows` directory and paste:

```yml
name: labeler

on: [pull_request]

jobs:
  labeler:
    runs-on: ubuntu-latest
    name: Label the PR size
    steps:
      - uses: proteantecs/pr-size-labeler@v2
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          xs_max_size: '10'
          s_max_size: '100'
          m_max_size: '500'
          l_max_size: '1000'
          fail_if_xl: 'false'
```

> If you want, you can customize all `*_max_size` with the size that fits in your project.

> Setting `fail_if_xl` to `'true'` will make fail all pull requests bigger than `l_max_size`.

## ⚖️ License

[MIT](LICENSE)
