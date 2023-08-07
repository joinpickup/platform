import {atom, action} from "nanostores"


export const menuBarOpen = atom(false)
export const toggleMenuBar = action(menuBarOpen, "toggleMenuBar", (store) => store.set(!store.get()))

export const loginDialogOpen = atom(false)
export const toggleLoginDialog = action(loginDialogOpen, "toggleLoginDialog", (store) => store.set(!store.get()))
