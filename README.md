# Convenient Utilities Linux
A series of utilities that make life easier on linux.

# Install
1. Clone the dir somewhere on your pc.
```
if ! [ -d ~/scripts ] ; then mkdir -p ~/scripts ; fi
cd ~/scripts
git clone https://github.com/adrianscheff/convenient-utils-linux
```
2. Add the dir path to .bashrc (or your terminal startup config file)
```
echo 'export PATH="~/scripts/convenient-utils-linux:$PATH"' >> ~/.bashrc
```
3. Reload your terminal.
```
source ~/.bashrc
```

# Uninstall
1. Delete the dir where the downloaded files are.
```
rm ~/scripts/convenient-utils-linux -r
```
2. Remove the added line to .bashrc. It should be something like
```
export PATH="~/scripts/convenient-utils-linux:$PATH"
```

# Use
* Just call the desired utility. The 'show' family start with the keyword 'show' and continue with something relevant.
* For example to show users type 'showu'. [show][u] - show users, alright?
* showg - showgroup. showp - showpath. showbf - showbigfiles. showus - show user space. etc
* Here's a favourite one liner. Show total file size & count for every user in the root dir. 
<br>
```
for u in $(showu); do showus -u $u -d / ; done
```
<br>
![show2 usage](./img/showus2.gif)





# General Presentation
![gen usage](./img/gen_use.gif)

# showbf
* show big files. First 10 by default, current user, current dir. 
* Use it with different user, different dir.
* Works well with files that have spaces or other "funky" chars. 

# showus
* Show a user disk usage AND file count in a dir. Calculates by adding file sizes owned by user. 
* It uses kibibytes (1KiB = 1024 Bytes). It may show slightly different results from ls. Not sure why. I think that ls might round results after dividing. This script doesn't. 
![gen usage](./img/showus_use.gif)


# showbl
* show broken links. Use custom dir or custom user

# showg
* Show groups, every group on one line.
* It's a simple one liner (in the script) but quite convenient to use in this form.

# showp
* Show paths added to $PATH, each on one line

# showu
* Show users, each on a separate line.

# wtw
* What's the word? A simple one liner (in script) to show possible words for regex.
![gen usage](./img/wtw_use.gif)



