# fabric

[fabric](https://github.com/danielmiessler/fabric/tree/main) is an open-source framework for augmenting humans using AI. (Source: github.com/danielmiessler/fabric/tree/main)

In short fabric is a command-line framework which allows you to interact with AI models, both locally and remotely. It does this by using what it calls 'patterns' which allow you to use pre-built or custom context window instructions to interact with the AI model.

> [!NOTE]
> The new version of fabric requires that you have `go` installed on your system. You can download `go` from the [official website](https://golang.org/dl/).

The details of how to install and use fabric can be found on the [fabric GitHub page](https://github.com/danielmiessler/fabric/tree/main). The page also has links to several youtube videos that explain how to install and use fabric. The one by [NetworkChuck]() is how I first learned about fabric.

**Using fabric**

For more detailed information about how to use fabric, please refer to the [fabric GitHub page](https://github.com/danielmiessler/fabric/tree/main). The page has a lot of information about how to use fabric. But here is a quick example of how to use fabric:

```bash
# This is a simple example of using fabric with the default AI model
echo "What are some best practices for writing a SQL query?" | fabric
```
> [!NOTE]
> The above command does not use a `pattern` and will use the default AI model. You can set the default model during the setup process by running `fabric --setup` or later by `fabric --changeDefaultModel`.

To specify a different model you can use the `--model` flag followed by the name of the model. For example, to use the `gemini-1.5-pro` model you would use the following command:
```bash
echo "What are some best practices for writing a SQL query?" | fabric --model gemini-1.5-pro
```
But the real power of fabric comes from using `patterns`. A `pattern` or the flag `-p` are instructions that you provide the AI model. It is just a markdown file that you create or use from the pre-built patterns that come with fabric. You can see a list of the pre-built patterns by running `fabric --listpatterns` or `fabric -l`. Here is an example of using a pattern:
```bash
# This will get a video transcript from youtube and get the key points from the video
yt -transcript "https://www.youtube.com/watch?v=UbDyjIIGaxQ&t=1154s" | fabric --model gemini-1.5-pro-latest -p extract_wisdom
```