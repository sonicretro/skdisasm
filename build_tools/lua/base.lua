local function build_rom(input_filename, output_filename, p2bin_arguments, improved_sound_driver_compression)
	local common = require "build_tools.lua.common"

	-- Obtain the paths to the native build tools for the current platform.
	local tools, platform_directory = common.find_tools("s3p2bin")

	-- Present an error message to the user if the build tools for their platform do not exist.
	if not tools then
		print(string.format("\z
			Sorry, the s3p2bin tool for your platform is outdated and needs recompiling.\n\z
			\n\z
			You can find the source code in 'build_tools/s3p2bin'.\n\z
			Once compiled, copy the executable to '%s'.\n\z
			\n\z
			We'd appreciate it if you could send us your binary in a pull request at\n\z
			https://github.com/sonicretro/skdisasm, so that other users don't have this\n\z
			problem in the future.", platform_directory))

		return false
	end

	-- Delete old ROM.
	os.remove(output_filename .. ".prev.bin")

	-- Backup the most recent ROM.
	os.rename(output_filename .. ".bin", output_filename .. ".prev.bin")

	local log_filename = input_filename .. ".log"

	-- Assemble the ROM.
	local assemble_result = common.assemble_file(input_filename .. ".asm", output_filename .. ".bin", tools.as, p2bin_arguments, tools.s3p2bin, improved_sound_driver_compression and "" or "-a", false)

	if assemble_result == "crash" then
		print "\n\z
			**********************************************************************\n\z
			*                                                                    *\n\z
			*         The assembler crashed. See above for more details.         *\n\z
			*                                                                    *\n\z
			**********************************************************************\n\z"

		return false
	elseif assemble_result == "error" then
		for line in io.lines(log_filename) do
			print(line)
		end

		print("\n\z
			**********************************************************************\n\z
			*                                                                    *\n\z
			*     There were build errors. See " .. log_filename .. " for more details.     *\n\z
			*                                                                    *\n\z
			**********************************************************************\n\z")

		return false
	end

	-- Correct the ROM's header with a proper checksum and end-of-ROM value.
	common.fix_header(output_filename .. ".bin")

	if assemble_result == "warning" then
		for line in io.lines(log_filename) do
			print(line)
		end

		print("\n\z
			**********************************************************************\n\z
			*                                                                    *\n\z
			*    There were build warnings. See " .. log_filename .. " for more details.    *\n\z
			*                                                                    *\n\z
			**********************************************************************\n\z")

		return false
	end

	-- A successful build; we can quit now.
	return true
end

return {build_rom = build_rom}
