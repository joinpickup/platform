import { createEffect, createSignal } from "solid-js"
import type { User } from "../../models/user";
import type { Post } from "../../models/post";
import PocketBase from "pocketbase";

enum LocalState {
    INIT,
    LOADING,
    ERROR,
    COMPLETE
}

const pb = new PocketBase("https://api.joinpickup.com");


type UserHeaderProps = {
    user: User;
}

function UserHeader(props: UserHeaderProps) {
    return (
        <div>
            Welcome {props.user.name}
        </div>
    )
}


export default function LoginPage() {
    const [username, setUsername] = createSignal<string>("")
    const [password, setPassword] = createSignal<string>("")
    const [user, setUser] = createSignal<User>()
    const [state, setState] = createSignal<LocalState>(LocalState.INIT)
    const [error, setError] = createSignal<string>("")


    function LoginForm() {
        return (
                <div class="flex flex-col space-y-2">
                    <div class="flex flex-col space-y-2">
                        <div class="flex flex-col space-y-1">
                            <input 
                                class="border-2 border-black p-4 rounded-lg placeholder:text-black"
                                value={username()}
                                onChange={(e) => setUsername(e.currentTarget.value)}
                                placeholder="Username..."
                            >
                            </input>
                            <input 
                                class="border-2 border-black p-4 rounded-lg placeholder:text-black"
                                value={password()}
                                type="password"
                                onChange={(e) => setPassword(e.currentTarget.value)}
                                placeholder="Password..."
                            >
                            </input>
            
                            </div>
                        <button class="border-2 rounded-lg p-4 border-black" onclick={loginWithBasic}>Login</button>
                    </div> 
                    <div class="border rounded-full border-black w-full"></div>
                    <div>
                        <button class="border-2 rounded-lg p-4 border-black" onclick={loginWithGoogle}>Login With Google</button>
                    </div>
                </div>
        )
    }

    function loginWithBasic() {
        setState(LocalState.LOADING)

        pb
            .collection("users")
            .authWithPassword<User>(username(), password())
            .then(res => {
                setUser(res.record)
                setState(LocalState.COMPLETE)
            })
            .catch(e => {
                setState(LocalState.ERROR)
                setError(e.data.message)
            })
        ;
    }

    
    function loginWithGoogle() {
        setState(LocalState.LOADING)

        pb
            .collection("users")
            .authWithOAuth2<User>({ provider: 'google' })
            .then(res => {
                setUser(res.record)
                setState(LocalState.COMPLETE)
            })
            .catch(e => {
                setState(LocalState.ERROR)
                setError(e.data.message)
            })
        ;
    }


    function logout() {
        setState(LocalState.LOADING)
        setUser()
        pb.authStore.clear();
        setState(LocalState.INIT)
    }
        
    return (
        <div class="flex flex-col space-y-2 m-4">
            {
                state() == LocalState.COMPLETE ? 
                    <UserHeader user={user() as User}/> 
                : state() == LocalState.LOADING ?
                    <div>
                        Loading...
                    </div> 
                : state() == LocalState.ERROR ?
                    <div>Error: {error()}</div> 
                :
                    <></>
            }

            {
                    user() ? 
                        <div class="flex">
                            <button class="border-2 rounded-lg p-4 border-black" onclick={logout}>Logout</button>
                        </div>
                    : <LoginForm />
            }
        </div>
    )
}