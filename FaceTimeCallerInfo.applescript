tell application "System Events"
	local lastPhoneNumber
	
	repeat
		try
			if exists (process "FaceTime") then
				set theProcess to process "FaceTime"
				if exists (windows of theProcess) then
					set theWindows to (windows of theProcess)
					repeat with theWindow in theWindows
						if (name of theWindow) is equal to (missing value) then
							set theContents to (entire contents of theWindow)
							repeat with theContent in theContents
								if (class of theContent) is equal to (static text) then
									set nameOfTheContent to (name of theContent) as text
									if (get character 2 of nameOfTheContent) is equal to "0" then
										set phoneNumber to (get characters 2 thru ((length of nameOfTheContent) - 1) of nameOfTheContent) as text
										if phoneNumber is not equal to lastPhoneNumber then
											set lastPhoneNumber to phoneNumber
											
											set result to (do shell script "curl \"http://www.whox2.com/view/result.jsp?hdCountryCd=82&phoneNo=" & phoneNumber & "\" | textutil -stdin -stdout -format html -convert txt -encoding UTF-8 | tr -s \"
	 \" \" \"")
											display notification result
										end if
									end if
								end if
							end repeat
						else
							set lastPhoneNumber to (missing value)
						end if
					end repeat
				else
					set lastPhoneNumber to (missing value)
				end if
			else
				set lastPhoneNumber to (missing value)
			end if
		end try
		
		delay 1
	end repeat
end tell
