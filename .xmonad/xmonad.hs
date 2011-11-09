import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import qualified XMonad.StackSet as W


myTerminal = "urxvt"

myModMask = mod4Mask -- set mod key to windows key

myLayoutHook = avoidStruts
               $ smartBorders
               $ onWorkspace "9" pidginLayout
               $ (Tall 1 (3/100) (1/2) ||| Full)
    where
      pidginLayout = reflectHoriz
                     $ withIM (0.15) (Role "buddy_list") Grid

myManageHook =
    composeAll
    [ manageHook gnomeConfig
    , isFullscreen --> doFullFloat -- make full-screen windows work
      -- launch certain programs only on certain workspaces
    , className =? "Pidgin"    --> doF (W.shift "9")
    , className =? "Skype"     --> doF (W.shift "9")
    , className =? "Rhythmbox" --> doF (W.shift "7")
    ]

main = xmonad $ gnomeConfig
       { manageHook = myManageHook
--       , modMask = myModMask
       , layoutHook = myLayoutHook
       , terminal   = myTerminal
       }
