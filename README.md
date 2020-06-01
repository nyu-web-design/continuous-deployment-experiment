# Example of Continuous Deployment of Static Web Content

This code repository shows how to perform **continuous deployment** of static web content to a remote web server, followed by automated testing of that web site.

## Automated deployment

Every push to GitHub results in an automatic deployment to a remote server. All files in the repository are copied to the server.

## Automation framework

This example depends upon GitHub's Actions framework for automation. The automation framework requires that you configure a few settings in your repository, both in the code, in a file named `settings.json`, as well in the GitHub repository's settings online.

### Settings

The following settings are necessary:

1. The remote hostname, username, and other information must be accurately documented in the file named `settings.json`.
1. The local development machine must have an SSH key pair. Run the command, `cat ~/.ssh/id_rsa.pub` - if you see something, you already have a key pair. If not, generate one by run the command, `ssh-keygen -f ~/.ssh/id_rsa -q -P ""` - this will create a private and a public key. The private key will be in the file `~/.ssh/id_rsa` - keep this private! The public key will be in the file`~/.ssh/id_rsa.pub` - feel free to share this.
1. Copy the public key to the server. Use the command `ssh-copy-id fb1258@i6.cims.nyu.edu` - replace `fb1258` with your username and `i6.cims.nyu.edu` as your server's hostname. If this doesn't work, run the command, `cat ~/.ssh/id_rsa.pub | ssh fb1258@i6.cims.nyu.edu "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys"`, where your username and hostname are plugged in place of `fb1258` and `i6.cims.nyu.edu`.
1. in the GitHub repository's `Settings` tab, click on `Secrets` and create a new secret with the name `DEPLOY_KEY` and paste your local computer's public SSH key as the value.

## Automated testing

Once deployed, the live web app is run through automated tests. Example tests in the `tests` directory attempt to show a variety of front-end testing techniques, including:

- testing the text in the page title
- testing the text in an element
- testing the color of text in an element
- testing the hover behavior of an element
- testing whether a link with given text exists
- testing whether a link with given href exists
- testing the responsive page width at different browser widths

It does so by popping open a web browser, loading the target page, and testing it through browser automation.

### Dependencies

The automated tests in this example are written in Python, and require the following Python modules:

- pytest
- selenium

Additional, to run these tests, you must separately install:

- the [selenium driver](https://sites.google.com/a/chromium.org/chromedriver/downloads) suitable for your local version of Google Chrome
- the location of the selenium driver you download must be added to your system's PATH variable.... instructions for doing this are readily available.
- alternatively, simply place the selenium driver into a directory that is already in your PATH variable... to see which directories are already in the PATH variable, run `echo $PATH` in Mac OSX's Terminal, or run `echo %PATH%` within Windows' `cmd` command shell.

### Running the tests

Running the automated tests can be accomplished by running the `pytest` framework. Tests can be run from either an IDE or from the command-line. Examples:

- From Visual Studio Code, click the Tests icon in the left tool bar, and click the run button towards the top-left of the window. See [a tutorial video on setting up Visual Studio Code](https://www.youtube.com/watch?v=xsXMzyK1M4I), including running pytest in this way.
- From the main project directory, run the command `pytest`. If that doesn't work, try `python3 -m pytest`. If you see an error that the module named pytest is not installed, first run the command `pip install pytest`, and then try again.
