# Password hashing script

Main author: [Kevin Ramirez](https://www.linkedin.com/in/kevin-ramirez-b37326183/)

This project is a simple script written in [Ruby](https://www.ruby-lang.org/en/) to go through a text file and hash strings for a hackathon (school event).  Once script is finished running, the results are saved to a spreadsheet that can used as an excel or google sheets spreadsheet. This is a school project that was built for the torohack event in IT Practicum course at [CSUDH.](https://www.csudh.edu/)

## Installation

 [Install the Ruby](https://www.ruby-lang.org/en/documentation/installation/) programming language on your local machine to run the script.

You may already have Ruby installed.  This can be checked by typing:
```bash
ruby -v
```

### Install Ruby on MacOS
Follow official [guide here](https://www.ruby-lang.org/en/documentation/installation/#homebrew) to install via [Homebrew](https://brew.sh/) 

### Install Ruby on Windows
Follow official [guide here](https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller) for windows installer.

## Script Usage & Example Run
This script allows for the following hahsing methods:
- MD5
- SHA-256
- SHA-512
- Bcrypt
- Scrypt

This can be run with any text file that contains strings (meant to hash passwords for a hackathon event)

The script can be ran via the terminal.  See example  below (done on Windows):
```bash
.\hashPasswords.rb 
```

Also included is a seperate file called: checkProfanity.rb that can be run on a text file to find all of the offensive language detected by [SwearJar](https://github.com/joshbuddy/swearjar) 

To run the profanity check, modify the code to include your desired text file and see the below example:
```
.\checkProfanity.rb
```

## Contributing
NOTE: This is not 100% finished.  Needs improvements for easier experience.

Pull requests welcome. 
