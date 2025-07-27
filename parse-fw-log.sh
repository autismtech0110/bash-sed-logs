#!/bin/bash

# Prompt user for filename
echo "Paste the filename of the log: "
# read captures user input and stores it in the variable, filename
read filename

# Define sed function...
# sed s substitutes newline (\n) after a regex, which gets enclosed in / / ; 
# & is used to include the delimiter (i.e. the regex term); /g means global, 
# i.e. all instances of the regex term; there are four different regex terms here
sed_log() {
  sed 's/Discards/&\n/g; s/etc.)/&\n/g; s/Request/&\n/g; s/times/&\n/g; s/attack/&\n/g; s/Error/&\n/g; s/Packet/&\n/g' "$filename"
}
# Call function for output to terminal only
sed_log "$filename"
# Blank line for legibility
echo

# Verify output, if it looks okay then save as new file
echo "Do you want to write this output to a new file? [Y/n] "
read Y_N
# Convert user input to lowercase
y_n=${Y_N,,}

# Next step based on user input
if [[ $y_n == "n" ]]; then
  echo "Output was NOT written to file."
elif [[ $y_n == "y" ]]; then
  # Create the filename for the new file, just add "parsed-" to beginning
  new_filename="parsed-""$filename"
  # Call function and write to new file in my Parsed/ directory
  sed_log "$filename" > "../Parsed/${new_filename}"
  # Confirmation message
  echo "Output was written to the file $new_filename."
else
  echo "Invalid input, try again."
fi
