--
-- Wallpaper Selector with Previews for Walker/Elephant
--
Name = "wallpapers"
NamePretty = "Wallpapers"

function GetEntries()
	local entries = {}
	local bg_dir = os.getenv("HOME") .. "/Pictures"
	local state_file = os.getenv("HOME") .. "/.cache/current_wallpaper.txt"

	-- Find all image files directly in the Pictures directory
	local find_cmd = "find -L '"
		.. bg_dir
		.. "' -maxdepth 1 -type f \\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\) 2>/dev/null | sort"

	local handle = io.popen(find_cmd)
	if not handle then
		return entries
	end

	for img_path in handle:lines() do
		-- Extract filename without extension for the label
		local file_name = img_path:match(".*/(.+)$")
		local display_name = file_name:gsub("%.%w+$", "") -- Remove extension
		display_name = display_name:gsub("_", " "):gsub("%-", " ") -- Clean up symbols

		-- Capitalize words for a cleaner look
		display_name = display_name:gsub("(%a)([%w_']*)", function(first, rest)
			return first:upper() .. rest:lower()
		end)

		table.insert(entries, {
			Text = display_name,
			Subtext = "Set as wallpaper",
			Icon = img_path, -- Optional: shows a small icon in the list
			Preview = img_path, -- This generates the large preview
			PreviewType = "file",
			Actions = {
				-- Update swww and the state file for your 'next-wallpaper' script
				activate = string.format('swww img "%s" && echo "%s" > "%s"', img_path, img_path, state_file),
			},
		})
	end

	handle:close()
	return entries
end
