import { createEffect, createSignal, onMount } from "solid-js"
import type { Post } from "../../models/post";
import { supabase } from "../../supabaseClient";
import { toggleMenuBar } from "../../store/layout";

enum DiscoverPageState {
    LOADING_POSTS,
    LOADED_POSTS
}

type PostCardProps = {
    currentPost: Post | undefined;
    post: Post;
    onClick: Function;
}

function PostCard(props: PostCardProps) {
    return (
        <button class={`p-4 rounded-lg border-black flex flex-col space-y-1 ${props.currentPost?.id == props.post.id ? "border-4" : "border-2"}`} onClick={() => props.onClick()}>
            <div class="text-2xl">
                {props.post.title}
            </div>
            <div class="text-sm">
                {props.post.body}
            </div>
        </button>
    )
}

export default function DiscoverPage() {
    const [state, setState] = createSignal<DiscoverPageState>()
    const [posts, setPosts] = createSignal<Post[] | null>()
    const [currentPost, setCurrentPost] = createSignal<Post>()

    function getPosts() {
        setState(DiscoverPageState.LOADING_POSTS)

        supabase
            .from("posts")
            .select("*, interests (id, name, space)")
            .returns<Post[]>()
            .order('created_at', { ascending: false })
            .then(res => {
                setPosts(res.data)
                setState(DiscoverPageState.LOADED_POSTS)
            })
    }

    function searchPosts(query: string) {
        setState(DiscoverPageState.LOADING_POSTS)

        supabase
            .from("posts")
            .select("*,interests (name)")
            .or(`body.ilike.*${query}*,title.ilike.*${query}*`)
            .returns<Post[]>()
            .then(res => {
                setPosts(res.data)
                setState(DiscoverPageState.LOADED_POSTS)
            })
    }


    onMount(() => {
        getPosts();
    })

    return (
        <div class="m-4 flex flex-col space-y-4">
            <div id="search-row" class="w-full border-2 border-black h-fit rounded-full p-1 flex space-x-2 items-center">
                <button 
                    id="leading-icon" 
                    class="p-2 rounded-full w-fit border-2 border-black"
                    onClick={() => {
                        toggleMenuBar()
                    }}
                >
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="w-6 h-6 bg-inherit"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke-width="1.5"
                        stroke="currentColor"
                    >
                        <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25H12"></path>
                    </svg>
                </button>
                <div id="search-box" class="flex-1 rounded-full">
                    <input
                        placeholder="Search..."
                        class="rounded-full px-4 py-2 bg-transparent w-full placeholder:text-black"
                        onchange={(event) => {
                            searchPosts(event.target.value)
                        }}
                    />
                </div>
            </div>
            <div id="filter-row" class="flex space-x-2 items-center">
                <button id="filter-chip" class="p-4 rounded-full px-4 py-1 border-2 border-black w-fit">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h9.75M10.5 6a1.5 1.5 0 11-3 0m3 0a1.5 1.5 0 10-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-9.75 0h9.75" />
                    </svg>
                </button>
                <button id="filter-chip" class="p-4 rounded-full px-4 py-1 border-2 border-black w-fit text-base flex space-x-2">
                    <div>
                        Space
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                    </svg>
                </button>
                <button id="filter-chip" class="p-4 rounded-full px-4 py-1 border-2 border-black w-fit text-base flex space-x-2">
                    <div>
                        Interests
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                    </svg>
                </button>
            </div>
            <div id="post-row" class="flex-1 flex space-x-2 w-full">
                {
                    state() == DiscoverPageState.LOADING_POSTS ? <div>Loading...</div> 
                    : (
                         <ul id="post-list" class={`${currentPost() ? "flex-2" : "flex-1"} flex space-y-2 flex-col`}>
                            {
                                posts()?.map(post => {
                                    return (
                                        <PostCard 
                                            currentPost={currentPost()}
                                            post={post} 
                                            onClick={() => {
                                                    setCurrentPost(currentPost()?.id === post.id ? undefined : post)
                                                }
                                            } 
                                        />
                                    )
                                })
                            }
                        </ul> 
                    ) 
                }
                {
                    currentPost() ? 
                        <div id="post-preview" class="flex-1 w-full rounded-lg border-black border-2 h-fit p-4"> 
                            <div>
                                {currentPost()?.title}
                            </div>
                            <div class="text-base">
                                {currentPost()?.body}
                            </div>

                        </div>
                    : <></>
                }
            </div>
        </div>
    )
}