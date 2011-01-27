import System.IO
import qualified Data.Map as M
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W


myWorkspaces =
    [ "web", "mail", "chat", "term", "code" , "music" , "?", "gimp", "vm" ]

myTerminal = "urxvt"

-- set mod to super (default is left-alt)
myModMask = mod4Mask

myKeys x =
    [ ((modMask x .|. shiftMask, xK_s), spawn "gnome-screensaver-command -l")
    , ((modMask x, xK_equal), spawn "amixer set 'Master' 5%+")
    , ((modMask x, xK_minus), spawn "amixer set 'Master' 5%-")
    , ((modMask x, xK_x), spawn "rhythmbox-client --no-present --play-pause")
    , ((modMask x, xK_z), spawn "rhythmbox-client --no-present --previous")
    , ((modMask x, xK_c), spawn "rhythmbox-client --no-present --next")
    --, ((modMask x, xK_b), sendMessage ToggleStruts) -- doesn't work right :(

    ]
myKeyMap x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

myLayoutHook = avoidStruts
               $ smartBorders
               $ onWorkspace "gimp" gimpLayout
               $ onWorkspace "chat" pidginLayout
               $ layoutHook defaultConfig
    where
      gimpLayout = withIM (0.11) (Role "gimp-toolbox")
                   $ reflectHoriz
                   $ withIM (0.15) (Role "gimp-dock") Full
      pidginLayout = reflectHoriz $ withIM (0.15) (Role "buddy_list") Grid

myManageHook =
    composeAll
    [ isFullscreen --> doFullFloat -- make full-screen windows work
      -- launch certain programs only on certain workspaces
    , className =? "Pidgin"    --> doF (W.shift "chat")
    , className =? "Skype"     --> doF (W.shift "chat")
    , className =? "Rhythmbox" --> doF (W.shift "music")
    ] <+> manageHook defaultConfig

-- logging for xmobar to use
myLogHook h = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h }

-- xmobar styling
myPP =
    xmobarPP
    { ppCurrent = xmobarColor "#00B000" ""
    , ppVisible = xmobarColor "#B0B000" ""
    , ppHidden  = xmobarColor "#B0B0B0" ""
    , ppHiddenNoWindows = xmobarColor "#606060" ""
    , ppUrgent  = xmobarColor "orange" ""
    , ppSep     = "   "
    , ppWsSep   = "  "
      -- This centers the window title, but fails when there's no window
    , ppTitle   = wrap "}" "{" . xmobarColor "#00A000" ""
    }

main = do
  xmproc <- spawnPipe "xmobar"  -- start xmobar
  xmonad $ defaultConfig
             { manageHook = myManageHook
             , layoutHook = myLayoutHook
	     --, borderWidth = myBorderWidth
	     --, normalBorderColor = myNormalBorderColor
	     --, focusedBorderColor = myFocusedBorderColor
             , terminal = myTerminal
             , modMask = myModMask
             , keys = myKeyMap
	     , workspaces = myWorkspaces
             , logHook = myLogHook xmproc
             --, focusFollowsMouse = False
	     }
