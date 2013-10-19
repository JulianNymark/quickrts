utils = {}

function utils.img_load_dir( dir )
	local files = fs.enumerate( dir )

	local t = {}
	for i, file in pairs(files) do
		local path = dir.."/"..file
		local name = string.sub(file, 0, #file - 4)
		t[name] = gr.newImage(path)
	end
	return t
end

function utils.sum( t )
	local sum = 0
	
	for i,e in pairs(t) do
		sum = sum + e
	end
	return sum
end
