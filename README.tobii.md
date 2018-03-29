### Update Tobii specific files

Install the dependencies:

```bash
npm install
```

#### Update adapter.screenshare.tobii.js

We need to check that files we have made our own copies of have not changed (see skylinkjs/tobii/README.md):

```bash
diff tobii/adapter.screenshare.orig.js node_modules/adapterjs/publish/adapter.screenshare.js
```

If the diff was not empty then we need to update our two copies of this file. First check what manual changes are needed:

```bash
diff --ignore-all-space --ignore-blank-lines tobii/adapter.screenshare.orig.js tobii/adapter.screenshare.tobii.js
```

Then do:

```bash
cp node_modules/adapterjs/publish/adapter.screenshare.js tobii/adapter.screenshare.orig.js
cp node_modules/adapterjs/publish/adapter.screenshare.js tobii/adapter.screenshare.tobii.js
```

and apply the appropriate changes to the tobii file according to the output from the diff command.

Commit the two updated files with the commit message: "Updated to new version of adapter.screenshare.js"

#### Update detectRTC.tobii.html

detectRTC.html is referenced by adapter.screenshare.js but we want our own local version so we need to make a
local copy of it. First double check that this is still the case and that the URL is the one in the curl command below:

```bash
grep 'detectRTC.html' tobii/adapter.screenshare.orig.js
```

```bash
curl https://cdn.temasys.com.sg/skylink/extensions/detectRTC.html --compressed -o /tmp/detectRTC.html.$$
diff --ignore-all-space --ignore-blank-lines tobii/detectRTC.orig.html /tmp/detectRTC.html.$$
```

If the diff was not empty then we need to update our two copies of this file. First check what manual changes are needed:

```bash
diff --ignore-all-space --ignore-blank-lines tobii/detectRTC.orig.html tobii/detectRTC.tobii.html
```

Then do:

```bash
cp /tmp/detectRTC.html.$$ tobii/detectRTC.orig.html
cp /tmp/detectRTC.html.$$ tobii/detectRTC.tobii.html
```

and apply the appropriate changes to the tobii file according to the output from the diff command.

Commit the two updated files with the commit message: "Updated to new version of detectRTC.html"

### Generate/publish

Generate the files to be deployed:

```bash
node_modules/.bin/grunt publish
```

### Commit, tag and push a release

```bash
git add . # Feel free to be more specific and skip adding generated doc files
git commit -m "publish 0.6.13-tobii.1"
git tag 0.6.13-tobii.1
git push --follow-tags
```

**NOTE** The tag name should be postfixed with a unique number, e.g. 0.6.13-tobii.1 or 0.6.13-tobii.2.
