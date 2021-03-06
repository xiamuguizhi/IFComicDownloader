------------------------------------------------------------
---slide.sports.sina.com.cn
------------------------------------------------------------
function PictureUrlAnalyse(url)
    local pagestr, err = DownloadURL(url, "", "")
	if type(pagestr) ~= "string" then
		return nil, "DownloadURL " .. url .. " failed\nbecasuse " .. err
	end
	return PicturePageAnalyse(url, pagestr, "")
end

function PicturePageAnalyse(picture_page_url, pagestr, extra_info)
    local result = "<result>"

	if type(picture_page_url) ~= "string" then
		return nil, "error because picture_page_url is not string, but " .. type(picture_page_url)
	end
	
	if type(pagestr) ~= "string" then
		return nil, "error because pagestr is not string, but " .. type(pagestr)
	end
    
    local picture_index_num, err = GetPageIndexFromURL(picture_page_url)
    if type(picture_index_num) ~= "number" then
        return nil, "error when GetPageIndexFromURL\nbecause: " .. err
    end

    -- getting file URL
    local start_index = JumpStr(pagestr, 1, "<dl>", picture_index_num)
    if type(start_index) ~= "number" then
        return nil, "error when looking for <dl>"
    end
    
    start_index = JumpStr(pagestr, start_index, "<dd>", 1)
    if type(start_index) ~= "number" then
        return nil, "error when looking for <dd>"
    end
    
    local file_url = GetStr(pagestr, start_index, "<")
    if type(file_url) ~= "string" then
        return nil, "error when trying to get file URL string"
    end
    
    --------------------------------------------------------------------
    result = result .. "<fileurl>"
    result = result .. file_url
    result = result .. "</fileurl>"
    --------------------------------------------------------------------
    result = result .. "<refererurl>"
    result = result .. picture_page_url
    result = result .. "</refererurl>"
    --------------------------------------------------------------------
    result = result .. "</result>"
    
    return result
end

function GetPageIndexFromURL(url)
	local index = GetLastPos(url, "=")
	if type(index) ~= "number" then
		return nil, "Can\'t find \'=\' from url " .. url
	end
	local page_index_str = string.sub(url, index + 1, string.len(url))
	
	local page_index_num = tonumber(page_index_str)
	if type(page_index_num) ~= "number" then
		return nil, "Can\'t tranform page index string \"" .. page_index_str .. "\" to number"
	end
	
	return page_index_num
end

function FindFileUrl(analyse_result)
    local start_index = JumpStr(analyse_result, 1, "<fileurl>", 1)
    if type(start_index) ~= "number" then
        return nil, "error when call JumpStr"
    end

    local file_url = GetStr(analyse_result, start_index, "<")
    if type(file_url) ~= "string" then
        return nil, "error when call GetStr"
    end
    return file_url
end

function FindFileRefererUrl(analyse_result)
    local start_index = JumpStr(analyse_result, 1, "<refererurl>", 1)
    if type(start_index) ~= "number" then
        return nil, "error when call JumpStr"
    end

    local referre_url = GetStr(analyse_result, start_index, "<")
    if type(referre_url) ~= "string" then
        return nil, "error when call GetStr"
    end
    return referre_url
end
