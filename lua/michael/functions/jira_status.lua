local M = {
	jira_raw_text = "NONE",
	jira_display_text = "Jira: ???",
	jira_ticket_url = "https://rfsmart-products.atlassian.net/browse/",
	ticket_is_error = false,
}

function M.update_jira_status()
	local api_token = os.getenv("JIRA_API_TOKEN")
	local domain = "rfsmart-products.atlassian.net"
	local email = "jonathon.robel@rfsmart.com"
	local jql_filters =
		"((assignee = currentUser() AND status = 'Dev In Progress') OR ('PR Reviewer[User Picker (single user)]' = currentUser() AND status = 'PR Review')) AND (spaceJira = Netsuite OR spaceJira = SummitIT)"

	-- Use vim.fn.jobstart to run this asynchronously
	vim.fn.jobstart({
		"curl",
		"-s",
		"--request",
		"POST",
		"--url",
		"https://" .. domain .. "/rest/api/3/search/jql",
		"--user",
		email .. ":" .. api_token,
		"--header",
		"Content-Type: application/json",
		"--data",
		'{"jql": "' .. jql_filters .. '", "maxResults": 5, "fields": ["key"]}',
	}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data and data[1] ~= "" then
				local ok, decoded = pcall(vim.fn.json_decode, table.concat(data))
				if ok and decoded.issues then
					local keys = {}
					for _, issue in ipairs(decoded.issues) do
						table.insert(keys, issue.key)
					end

					if #keys == 0 then
						M.jira_display_text = "Jira: NONE"
						M.jira_raw_text = "NONE"
						M.ticket_is_error = true
					else
						M.jira_display_text = "Jira: " .. table.concat(keys, ", ")
						M.jira_raw_text = table.concat(keys, ",")
						M.ticket_is_error = (#keys > 1)
					end

					if #keys >= 1 then
						M.jira_ticket_url = "https://rfsmart-products.atlassian.net/browse/" .. keys[1]
					end
				end
			end
		end,
	})
end

return M
