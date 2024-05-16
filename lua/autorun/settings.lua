lwgcc_settings = {}

-- Message formats.

-- Placeholders for strings can be in the same string segment as other placeholders for strings. 
-- Replaces PLAYER_NAME with the player's name.
-- Replaces TEAM_NAME with the Team Name e.g. Owner.
-- Replaces USER_GROUP with the usergroup name e.g. superadmin.
-- Replaces TEAM_OR_UG with the team name, or if it's not found, the usergroup name.
-- Replaces MSG_CONTENT with the message content. Empty string in JoinMessageFormat.

-- Placeholders for colors must be in their own string segment.
-- Replaces TEAM_COLOR with the team (rank) color.
-- Replaces PLAYER_COLOR with the player's Player color.

lwgcc_settings.Format = { -- This can also probably be a function that returns a table of values like this? Dunno
    TEAM_COLOR,           -- Maybe you can return different tables based on usergroup or steamID or whatever
    TEAM_OR_UG,
    Color(0, 0, 0),
    " | ",
    TEAM_COLOR,
    PLAYER_NAME,
    Color(230, 230, 230),
    ": ",
    MSG_CONTENT,
}

-- Only Colors, string literals and PLAYER_NAME are valid in here

lwgcc_settings.JoinMessageFormat = {
    Color(0, 0, 0),
    "[",
    Color(0, 200, 0),
    "+",
    Color(0, 0, 0),
    "] ",
    Color(200, 200, 200),
    PLAYER_NAME,
    " joined."
}

-- functions

function resolvePlaceholders(husk, ply, content, playerName)
    local output = husk

    if type(output) == "table" then -- It's a constant color, skip it
        return output
    else
        output = string.gsub(output, "PLAYER_NAME", playerName or "PLAYER_NAME")

        if ply != nil then

            local tu = team.GetName(ply:Team())
            if tu == "Unassigned" then tu = ply:GetUserGroup() end

            if output == "TEAM_COLOR" then  
                return team.GetColor(ply:Team())
            elseif output == "PLAYER_COLOR" then
                return ply:GetPlayerColor():ToColor()
            end

            output = string.gsub(output, "TEAM_NAME", team.GetName(ply:Team()))
            output = string.gsub(output, "USER_GROUP", ply:GetUserGroup())
            output = string.gsub(output, "TEAM_OR_UG", tu)
            output = string.gsub(output, "PLAYER_NAME", ply:Name())

        end

        if content != nil then
            output = string.gsub(output, "MSG_CONTENT", content) -- CONTENT HAS TO ALWAYS BE LAST
        end
    end

    return output
end


-- Convenience
TEAM_COLOR = "TEAM_COLOR"
PLAYER_COLOR = "PLAYER_COLOR"
TEAM_NAME = "TEAM_NAME"
USER_GROUP = "USER_GROUP"
TEAM_OR_UG = "TEAM_OR_UG"
MSG_CONTENT = "MSG_CONTENT"
PLAYER_NAME = "PLAYER_NAME"