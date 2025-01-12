local function getLocalVersion()
    if fs.exists("currentVersion.txt") then
        local file = fs.open("currentVersion.txt", "r")
    
        local version = file.readLine()
    
        file.close()
    
        return version
    else
        print("Failed to check for updates. Ensure HTTP is enabled.")
    
        return nil
    end
end

local currentVersion = getLocalVersion()

local function clearScreen()
    term.clear()
    term.setCursorPos(1, 1)
end

local function displayMenu()
    clearScreen()
    print("Welcome to SynovaOS! Version: "..currentVersion)
    print("-------------------------")
    print("1. View Files")
    print("2. Edit a File")
    print("3. Run a Command")
    print("4. Create a New File")
    print("5. Delete a File")
    print("6. Clear Screen")
    print("7. Shutdown")
    print("8. Install a Game")
    print("9. Play Sound")
    print("-------------------------")
    print("Select an option (1-9): ")
end

local function viewFiles()
    clearScreen()
    print("Files in current directory:")
    local files = fs.list(".")
    for _, file in ipairs(files) do
        print("- " .. file)
    end
    print("\nPress Enter to return...")
    read()
end

local function editFile()
    clearScreen()
    print("Enter the name of the file to edit (or type 'exit' to return):")
    local fileName = read()
    
    if fileName == "exit" then
        return
    elseif fs.exists(fileName) then
        shell.run("edit " .. fileName)
    else
        print("File does not exist! Press Enter to continue...")
        read()
    end
end

local function runCommand()
    clearScreen()
    print("Enter the command to run (or type 'exit' to return):")
    local command = read()
    
    if command == "exit" then
        return
    else
        local success, result = pcall(shell.run, command)
        if not success then
            print("Error: " .. result)
            print("Press Enter to continue...")
            read()
        end
    end
end

local function createFile()
    clearScreen()
    print("Enter the name of the new file (or type 'exit' to return):")
    local fileName = read()

    if fileName == "exit" then
        return
    elseif fs.exists(fileName) then
        print("File already exists! Press Enter to continue...")
        read()
    else
        local file = fs.open(fileName, "w")
        print("Enter content for the file (type 'EOF' on a new line to finish):")
        while true do
            local line = read()
            if line == "EOF" then
                break
            end
            file.writeLine(line)
        end
        file.close()
        print("File created successfully! Press Enter to continue...")
        read()
    end
end

local function deleteFile()
    clearScreen()
    print("Enter the name of the file to delete (or type 'exit' to return):")
    local fileName = read()

    if fileName == "exit" then
        return
    elseif fs.exists(fileName) then
        fs.delete(fileName)
        print("File deleted successfully! Press Enter to continue...")
        read()
    else
        print("File does not exist! Press Enter to continue...")
        read()
    end
end

local function clearScreenOption()
    clearScreen()
    print("Screen cleared! Press Enter to return...")
    read()
end

while true do
    displayMenu()
    
    local choice = read()

    if choice == "1" then
        viewFiles()
    elseif choice == "2" then
        editFile()
    elseif choice == "3" then
        runCommand()
    elseif choice == "4" then
        createFile()
    elseif choice == "5" then
        deleteFile()
    elseif choice == "6" then
        clearScreenOption()
    elseif choice == "7" then
        print("Shutting down...")
        os.shutdown()
    elseif choice == "8" then
        
    elseif choice == "9" then
        shell.run("speaker play os/sounds/lets-go-gambling-x-slide.dfpwm")
    else
        print("Invalid choice! Please select again. Press Enter to continue...")
        read()
    end
end
