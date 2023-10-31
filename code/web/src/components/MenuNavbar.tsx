import type { JSXElement } from "solid-js";
import { menuBarOpen, toggleLoginDialog, toggleMenuBar } from "../store/layout"
import {useStore} from "@nanostores/solid"


export default function MenuNavbar() {
  const isActive = useStore(menuBarOpen);

  return (
    <>
    <main
      class={`${isActive() ? "absolute" : "hidden"} left-0 top-0 bottom-0 p-4 flex flex-col space-y-2 m-2 rounded-lg border-2 border-black`}
    >
      <TopBar />
      <Middle />
    </main>
    </>
  )
}


function TopBar() {
  return <div id="top-row" class="flex justify-between items-center space-x-4">
        <button id="profile" class="p-2 border-2 border-black rounded-full" onclick={() => {
          toggleLoginDialog()
        }}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-6 h-6"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z"
            ></path>
          </svg>
        </button>
        <button
          id="locale-selector"
          class="flex py-1 px-4 rounded-full space-x-2 w-fit h-fit items-center border-2 border-black"
        >
          <div class="text-sm">New Haven</div>

          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-6 h-6"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M19.5 8.25l-7.5 7.5-7.5-7.5"></path>
          </svg>
        </button>
        <button id="close" class="p-2 border-2 border-black rounded-full" onclick={() => {
          toggleMenuBar()
        }}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-6 h-6"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M9.75 9.75l4.5 4.5m0-4.5l-4.5 4.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            ></path>
          </svg>
        </button>
      </div>
}

function Middle() {
  return (
    <ul class="flex-1 p-2 space-y-2">
      <MenuItem 
        icon={
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
          </svg>
        }
        title="Discover"
        description="Search for new posts."
        link= "/discover"
      />
      <MenuItem 
        icon={
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 15.75l-2.489-2.489m0 0a3.375 3.375 0 10-4.773-4.773 3.375 3.375 0 004.774 4.774zM21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        }
        title="Searches"
        description="Look through your saved searches"
        link= "/profile/searches"
      />
      <MenuItem 
        icon={
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
</svg>


        }
        title="Post Admin"
        description="Keep track of and administer your posts"
        link= "/profile/posts"
      />
      <MenuItem 
        icon={
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 13.5h3.86a2.25 2.25 0 012.012 1.244l.256.512a2.25 2.25 0 002.013 1.244h3.218a2.25 2.25 0 002.013-1.244l.256-.512a2.25 2.25 0 012.013-1.244h3.859m-19.5.338V18a2.25 2.25 0 002.25 2.25h15A2.25 2.25 0 0021.75 18v-4.162c0-.224-.034-.447-.1-.661L19.24 5.338a2.25 2.25 0 00-2.15-1.588H6.911a2.25 2.25 0 00-2.15 1.588L2.35 13.177a2.25 2.25 0 00-.1.661z" />
          </svg>
        }
        title="Inbox"
        description="Chat with current members about yours or their posts"
        link= "/profile/inbox"
      />
    </ul>
  )
}

type MenuItemProps = {
  icon: JSXElement;
  title: string;
  description: string;
  link: string;
}

function MenuItem(props: MenuItemProps) {
  return (
    <li class="cursor-pointer">
      <a 
        href={props.link}
        class="w-full rounded-lg p-2 flex space-x-4 items-center border-2 border-transparent hover:border-black">
        {props.icon}
        <div class="flex flex-col">
          <div class="text-lg">
            {props.title}
          </div>
          <div class="text-sm">
            {props.description}
          </div>
        </div>
      </a>
    </li>
  )
}