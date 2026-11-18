return {
    "brianhuster/live-preview.nvim",
    config = function()
        require("livepreview.config").set({
            picker = "snacks.picker",
        })
    end,
}
