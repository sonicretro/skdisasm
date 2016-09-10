#!/usr/bin/env python

import os
import platform
import sys
import hashlib
from subprocess import call
import subprocess

# Expected SHA-256 hashes and file sizes.
s3_usa_hash = "d6404843c5ba32486f4c8c744acb7e1932069376960d886b1de37969787d3f9c"
s3_usa_size = 2097152
sk_hash = "6e12e6b33c26ebfcd0be433251d21cf6284eafe9f71b027bda3767ae59affec1"
sk_size = 2097152

# Verbose errors?
verbose_errors = False

# Paths to build tools, depending on OS

if platform.system() == "Windows":
	asBinary = "AS/Win32/asw.exe";
	s3p2binBinary = "AS/Win32/s3p2bin.exe";

elif platform.system() == "Darwin": # Osx
	asBinary = "AS/Osx/asl";
	s3p2binBinary = "AS/Osx/s3p2bin";

elif platform.system() == "Linux":
	asBinary = "AS/Linux/asl";
	s3p2binBinary = "AS/Linux/s3p2bin";

else:
	print("Unknown platform")
	sys.exit(1)

def delete(path):
	if os.path.isfile(path):
		os.remove(path);

def makeDir(path):
	if not os.path.isdir(path):
		os.mkdir(path);

def build(targetName, def0, def1):

	print("Building "+targetName);

	# Create full paths for all files
	romPath = targetName + ".bin";	
	errorsPath = "Build/" + targetName + "Errors.txt";
	outputPath = "Build/" + targetName + "Output.txt";
	binaryOutputPath = "Build/" + targetName + "BinaryOutput.txt";

	print("  Cleaning previous build");
	# Remove old output
	delete(romPath);
	delete(errorsPath);
	delete(outputPath);
	delete(binaryOutputPath);
	delete("sonic3k.p");

	assembleCommand = [asBinary, "-x", "-xx", "-n", "-c", "-A", "-L"];

	assembleCommand.append(def0);
	assembleCommand.append(def1);

	# Input asm file
	assembleCommand.append("sonic3k.asm");

	print("  Assembling .p file");

	assembleProcess = subprocess.Popen(assembleCommand, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	output, errors = assembleProcess.communicate()
	errorsFile = open(errorsPath, "wb")
	errorsFile.write(errors)
	errorsFile.close()
	outputFile = open(outputPath, "wb")
	outputFile.write(output)
	outputFile.close()
	if assembleProcess.returncode != 0:
		if verbose_errors == True:
			# Print all errors.
			print(errors)
			# Print last 7 lines of stdout.
			outputlines = output.splitlines();
			for i in range(len(outputlines)-7, len(outputlines)):
				if i >= 0:
					print(outputlines[i])
			print("")
		print("  ERROR: Assembler returned " + str(assembleProcess.returncode) + ".")
		return assembleProcess.returncode

	# Create binary

	binaryCommand = [s3p2binBinary, "sonic3k.p", romPath, "sonic3k.h"];

	# Output file

	print("  Converting .p to .bin");

	binaryProcess = subprocess.Popen(binaryCommand, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	output, errors = binaryProcess.communicate()
	outputFile = open(binaryOutputPath, "wb")
	outputFile.write(output)
	outputFile.close()
	if binaryProcess.returncode != 0:
		if verbose_errors == True:
			print(errors)
		print("  ERROR: s3p2bin returned " + str(binaryProcess.returncode)) + "."
		return binaryProcess.returncode

	print("  Removing temporary files");

	# delete working files
	delete("sonic3k.p");
	delete("sonic3k.h");

	# Assembly was successful.
	return True

def check_hash(filePath, sha256_hash, filesize):
	"""Check the SHA-256 hash of the specified file.

	Parameters:
	- filePath: File to check.
	- sha256_hash: Expected SHA-256 hash.
	- filesize: Expected file size.
	"""

	print("  Checking '" + filePath + "'");
	actual_size = os.stat(filePath).st_size;
	if (actual_size != filesize):
		print("  File size is incorrect.")
		print("  - Expected: " + str(filesize))
		print("  - Actual:   " + str(actual_size))
		return False;

	fileToCheck = open(filePath, "rb");
	try:
		hashobj = hashlib.sha256();
		while True:
			buf = fileToCheck.read(4096)
			if buf == "":
				break

			hashobj.update(buf);
	finally:
		fileToCheck.close()

	# Check the SHA-256 hash.
	if (hashobj.hexdigest() != sha256_hash):
		print("  SHA-256 hash of file is incorrect.")
		print("  - Expected: " + sha256_hash)
		print("  - Actual:   " + hashobj.hexdigest())
		return False

	print("  s&k rom verified ok")
	return True

def run(build3k, buildSK, verifySK):

	# Navigate to base dir
	os.chdir("..");

	if platform.system() == "Windows":
		os.environ["AS_MSGPATH"] = "AS/Win32";
		os.environ["USEANSI"] = "n";

	# Create build dir
	makeDir("Build");

	# Build Sonic3&K Complete rom
	if build3k:
		build("sonic3k", "-D", "Sonic3_Complete=1");

	# Build S&K rom
	if buildSK:
		build("skbuilt", "-D", "Sonic3_Complete=0");

	# Compare the newly built s&k rom with the actual rom to make sure it's byte-identical
	if verifySK:
		check_hash("skbuilt.bin", sk_hash, sk_size);
		raw_input("Press any key to exit")

	print("Finished!");

def usage():
	print("Syntax: " + sys.argv[0] + " [targets]")
	print("")
	print("Options:")
	print("  -usage    Show command line usage.")
	print("  -verbose  Verbose error output.")
	print("")
	print("Valid targets:")
	print("  3K        Sonic 3 & Knuckles")
	print("  SK        Sonic & Knuckles")
	print("  verify    Compare built Sonic & Knuckles to original")

# Main program.
# NOTE: This file is included by buildS3Complete.py and buildSK.py, so we
# have to check if this is the main program for compatibility purposes.
if __name__ == "__main__":
	sys.dont_write_bytecode = True
	print("Sonic & Knuckles disassembly build script")
	os.chdir("..")

	# Options.
	build3K = False
	buildSK = False
	verifySK = False

	# Parse command line parameters.
	for i in range(1, len(sys.argv)):
		param = sys.argv[i].lower()
		if param == "3k":
			build3K = True
		elif param == "sk":
			buildSK = True
		elif param == "verify":
			verifySK = True
		elif param == "-usage":
			usage()
			sys.exit(0)
		elif param == "-verbose":
			verbose_errors = True
		else:
			print("Unrecognized option: " + sys.argv[i])
			usage()
			sys.exit(1)

	if build3K == False and buildSK == False and verifySK == False:
		print("No target(s) specified.")
		print("")
		usage()
		sys.exit(1)

	# Create build dir
	makeDir("Build");

	if build3K == True:
		print("")
		ret = build("sonic3k", "-D", "Sonic3_Complete=1")
		if ret == False:
			sys.exit(1)

	if buildSK == True:
		print("")
		ret = build("skbuilt", "-D", "Sonic3_Complete=0")
		if ret == False:
			sys.exit(1)

	if verifySK == True:
		print("")
		ret = check_hash("skbuilt.bin", sk_hash, sk_size);
		if ret == False:
			sys.exit(1)

	# All tasks completed.
	sys.exit(0)
