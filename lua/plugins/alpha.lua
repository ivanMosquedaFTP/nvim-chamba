return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
                                       ...........                                           
                          ........''',,,;;;;,,,''.....                                    
                 .....'''',,,;::;:c:;''''''',,,;:;,;;;,''..                               
               ..',;;::;;:,'..''..       ...     .',:,c::;'..                             
            ..',;c;,;,,'................. .. .. ......:;cc:;,..                           
          ..',:::,'................. ...  ..........',.',:;::;,..                         
        ..';c;:,'..........'...................''';;::;,,..':;:;'..                       
       ..,:c'.........,;'.............''''',,,,,,,;:::::::;'.,:::;'..                     
      ..;:c,...........''''''',,,,;,,,,,,,,,,,',,,,,;;;:::::c,';:::,..                    
     ..,:',...........'.'',,;;::;;;;;;;,,,,,,''''''',,,;;;:cccl':;c:,'..                  
    ..,,,.............''',;::::::::;;;,,,,,,,''''''',;,,,,,c::cc,,;c:;,..                 
   ..,;'............'.'',;::::::::::::;,,',''''''''',:;;;'.;:;:clc;;::;,'.                
   ..;;................',;:::::::::;:;;;,,,;,''''''.';;,:,.'c,,:::c;:;;;;'..              
   .':.................,,,;;::::::::;;;,''''............'..';,.'',,;,;:;;,'..             
  ..,:.........'.......,,,;;;:c:::;::,,''...'..............,,,',;::cllcc:l:'..            
  .';:' ..............',,,,;:cc:::;;,,'..',;:::::;,,',,'',,,cc;:lodxOkkxdxKd'..           
  .';:. ...........'''',',;clc:::::,'.';:clooxdddolc;,,;:c:;:lcldx0KNNN0x00k,'.           
  ..,:c............'''',,:ccc:::::;;,;:ccodxOKKK0kdoc;,;:cc:::cloxk0KX0OkOoo,,'.          
   .,;:'...........'''',;cccc::::;;:;;;:coxOKNNNX0xdc;,,;::::::clooooxdold,::;'.          
   ..,:,..............',:ccccc:::::;,,,;cldxkOOOkxdlc;;;::cccc::::ccc::::co;;;,..         
   ..';c ........'..'.',;clccc:::::;;,,;::cclllolc:;,,,;:cllllccc:;;:o:;;cod::;'.         
    ..,:c .............';:cclcc::::;;;:;;;;;::;:;,,,''',;cc:::cccc:;,lo,;cokk;;,..        
    ..';cc.......''''..',:ccclccccc:cc:c::::;;,,;''''''':cloc:::;::,;,c'.,ckk::,'.        
     ..;:cl..,,:;;:::;',;;ccllccccccccccccc:;,,,,,''''',;:cc,,,;,;;c;:;,''coo;c;,..       
     ..,:ccc'.:dccllll;,;;;ccccccccccccccc::;;;;;:'''',,,;,''''''''cc;;:;';ol:::,'.       
      .';:c:.':c:cocolc;',,;:cccccccccccc:;;:::::,'''',,,''''.'',,.,::;;;,,:o,:c:,.       
       .,:cc,.:::;,'clcl;''',;:clccccccc:;,;lcl:,''''''',',,,,;;,,,,:cloc;';c.:::;..      
       .';:c.':,''':llcll:'',,;::cc:c:;;;,':col,''''',;:::::::;::;;;occ''..';.;::;'.      
        .';::',...,:ooollc,,;;;,,;;;:;,;,'',:ol,''''',,;:clocxldocllxdx;c'..,.,cc:,..     
         ..,::;.,',:c;;lol;',,::c;;;;,,;,''';:c:,''..',;::::;:::::;::clxdd,.;''cc:;..     
          ..';::;:::c::cll:,',;;cc:;;,;,,'''',;:c;'..',;::::::::::,;;:clc:;'';.:c:;..     
             ..';;:ccc;.:::;,;;:::c:;;:;,'''..,;;;,..'.'',,;;;;,,''...,:::,,.;,:c:,..     
               ..',:cccccc;',:;;::;;;;;;;,''...',;,''....'''''.''....',,cc;,',::::;..     
                  ..,:cccc;,,::::;;;,,,,,,''....',,,'.................',::,'.';c:c;'.     
                   ..;cccc:',;;:ccc;;;,,'''''....';,'...................',...',:c;:,..    
                   ..,:cccc,,,;;;::::;;,,',''.....',;''......................';;:::;'.    
                    .';cccc:',,,,;::,;,',''''......';,''....................',,;:;:,..    
                    .';::cccc''',',',,,'',''........'',''.'.................'.';,;,'..    
                     .';::cccc; ...'..'..............'''''''.',...............'''';'.     
                      .';:::cccc;,' ......................,,'.,................'.::,.     
                        ....'',,,;;;;;;,,,;,,''..  ...................... .....,cc;'.     
                              .........''',,,;;::;,,   ............ .  ..  ..':c:;'.      
                                            .......',''..'..  .........'.,;:::;,'.        
                                                    ........''''''''''''''......          
                                                        ....................               ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", " " .. " Recent files",    LazyVim.pick("oldfiles")),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("l", " " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          dashboard.section.footer.val = "⚡ I'm a Neovim gigachad ⚡"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
