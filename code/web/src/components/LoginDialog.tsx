import {useStore} from "@nanostores/solid"
import { loginDialogOpen, toggleLoginDialog } from "../store/layout"
import { createSignal } from "solid-js";
import { supabase } from "../supabaseClient";

export default function LoginDialog() {
    const isActive = useStore(loginDialogOpen);

    return (
        <main class={`${isActive() ? "absolute" : "hidden"} m-2 h-1/2 top-0 left-0 right-0 rounded-lg border-2 border-black p-4 flex flex-col space-y-2`}>
            <TopRow />
            <MiddleRow />
        </main>
    )
}

function TopRow() {
    return (
            <div id="top-row" class="flex justify-between items-center space-x-4">
                <div class="text-xl">
                    Login or Signup
                </div>
                <button id="close" class="p-2 border-2 border-black rounded-full" onclick={() => {
                    toggleLoginDialog()
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
    )
}

function MiddleRow() {
    const [email, setEmail] = createSignal("")
    const [password, setPassword] = createSignal("")

    return (
            <div id="middle-row" class="flex flex-col space-y-2 flex-1">
                <input 
                    placeholder="email" 
                    type="email"
                    oninput={((e) => {
                        setEmail(e.target.value)
                    })}
                    class="rounded-lg border-black border-2 p-2" 
                />
                <input 
                    placeholder="password" 
                    oninput={((e) => {
                        setEmail(e.target.value)
                    })}
                    type="password"
                    class="rounded-lg border-black border-2 p-2"
                ></input>
                <div class="flex-1 flex flex-col space-y-2">
                <div class="flex-1 flex flex-col justify-end">
                    <button class="w-full rounded-full p-2 border-black border-2" onclick={async () => {
                        const {data, error} = await supabase.auth.signInWithPassword({
                            email: email(),
                            password: password(),
                        })

                        console.log(data)
                        console.log(error)
                    }}>
                        Login
                    </button>
                </div>
                <button class="underline" onclick={() => {
                    supabase.auth.resetPasswordForEmail('', {
                        redirectTo: 'http://example.com/account/update-password',
                    })
                }}>
                    Reset Password
                </button>

                </div>
            </div>
    )
}