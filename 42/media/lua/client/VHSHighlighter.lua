-- ============================================================
--  VHS Highlighter v1.7 - Build 42
--  Dibuja una barra de color de 4px a la izquierda del nombre
-- ============================================================

local VHS_COLORS = {
    ["VHS: The Cook Show E1"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E2"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E3"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E4"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E5"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E6"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: The Cook Show E7"] = { r=1.00, g=0.55, b=0.00 },
    ["VHS: Woodcraft E1"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E2"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E3"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E4"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E5"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E6"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Woodcraft E7"]         = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Exposure Survival E4"] = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Exposure Survival E8"] = { r=0.95, g=0.55, b=0.05 },
    ["VHS: Exposure Survival E3"] = { r=0.10, g=1.00, b=0.10 },
    ["VHS: Exposure Survival E1"] = { r=0.20, g=0.65, b=1.00 },
    ["VHS: Exposure Survival E2"] = { r=0.20, g=0.65, b=1.00 },
    ["VHS: Exposure Survival E5"] = { r=0.70, g=1.00, b=0.00 },
    ["VHS: Exposure Survival E6"] = { r=1.00, g=0.78, b=0.10 },
    ["VHS: Exposure Survival E7"] = { r=0.70, g=1.00, b=0.00 },
    ["VHS: Carzone E1"]         = { r=0.82, g=0.82, b=0.82 },
    ["VHS: Carzone E2"]         = { r=0.82, g=0.82, b=0.82 },
    ["VHS: Carzone E3"]         = { r=0.82, g=0.82, b=0.82 },
    ["Home VHS: OSCC '92"]      = { r=0.82, g=0.82, b=0.82 },
    ["Home VHS: stock cars"]    = { r=0.82, g=0.82, b=0.82 },
    ["Home VHS: Granny Nani"]   = { r=1.00, g=0.10, b=0.90 },
    ["Home VHS: Tailoring 101"] = { r=1.00, g=0.10, b=0.90 },
    ["Home VHS: nof vid"]       = { r=0.88, g=0.92, b=1.00 },
    ["Home VHS: no 9"]          = { r=0.88, g=0.92, b=1.00 },
    ["Home VHS: Muldraugh AV Club"] = { r=1.00, g=0.95, b=0.00 },
    ["Home VHS: TV repair"]         = { r=1.00, g=0.95, b=0.00 },
    ["Home VHS: RMFA"]                    = { r=1.00, g=0.10, b=0.10 },
    ["Home VHS: Combat Wound Management"] = { r=1.00, g=0.10, b=0.10 },
}

local barW = 4

local function drawColoredBars(self)
    if not self.itemslist then return end

    local YSCROLL  = self:getYScroll()
    local HEIGHT   = self:getHeight()
    local maxItems = ISInventoryPane.MAX_ITEMS_IN_STACK_TO_RENDER
    local row      = 0
    local barX     = self.column2 - barW - 1

    for _, v in ipairs(self.itemslist) do
        local count = 1
        for _, item in ipairs(v.items) do
            if count == 1 then
                local topOfItem = row * self.itemHgt + YSCROLL
                if topOfItem + self.itemHgt >= 0 and topOfItem <= HEIGHT then
                    local name = item:getDisplayName()
                    local c = VHS_COLORS[name]
                    if c then
                        local barY = row * self.itemHgt + self.headerHgt + 2
                        local barH = self.itemHgt - 4
                        self:drawRect(barX, barY, barW, barH, 1.0, c.r, c.g, c.b)
                    end
                end
            end
            row = row + 1
            if count == 1 and self.collapsed and v.name and self.collapsed[v.name] then break end
            if count == maxItems + 1 then break end
            count = count + 1
        end
    end
end

local _origRenderdetails = ISInventoryPane.renderdetails
if _origRenderdetails then
    ISInventoryPane.renderdetails = function(self, doDragged)
        _origRenderdetails(self, doDragged)
        if not doDragged then
            local ok, err = pcall(drawColoredBars, self)
            if not ok then print("[VHSHighlighter] ERROR: " .. tostring(err)) end
        end
    end
    print("[VHSHighlighter] v1.7 cargado.")
else
    print("[VHSHighlighter] ERROR: renderdetails no encontrada.")
end
