lwgcc_settings = {}

-- Message format.

-- Placeholders for strings can be in the same string segment as other placeholders for strings. 
-- Replaces USER_NAME with the player's name.
-- Replaces TEAM_NAME with the Team Name e.g. Owner.
-- Replaces USER_GROUP with the usergroup name e.g. superadmin.
-- Replaces TEAM_OR_UG with the team name, or if it's not found, the usergroup name.
-- Replaces MSG_CONTENT with the message content.

-- Placeholders for colors must be in their own string segment.
-- Replaces TEAM_COLOR with the team (rank) color.
-- Replaces PLAYER_COLOR with the player's Player color.

lwgcc_settings.Format = {
    Color(0, 0, 0),
    "[",
    TEAM_COLOR,
    TEAM_OR_UG,
    Color(0, 0, 0),
    "] ",
    PLAYER_COLOR,
    USER_NAME,
    Color(230, 230, 230),
    ": ",
    MSG_CONTENT,
}

-- functions

function resolvePlaceholders(husk, ply, content)
    local output = husk

    print("husk is " .. type(husk))
    print(husk)

    if type(output) == "table" then -- It's a constant color, skip it
        return output
    else
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
        output = string.gsub(output, "USER_NAME", ply:Name())
        output = string.gsub(output, "MSG_CONTENT", content) -- CONTENT HAS TO ALWAYS BE LAST
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
USER_NAME = "USER_NAME"