import { createSignal, onMount } from "solid-js"
import PocketBase from "pocketbase";
import type { Post } from "../../models/post";

enum DiscoverPageState {
    LOADING_POSTS,
    LOADED_POSTS
}

const pb = new PocketBase("https://api.joinpickup.com");

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
    const [_, setState] = createSignal<DiscoverPageState>()
    const [posts, setPosts] = createSignal<Post[]>()
    const [currPage, setCurrPage] = createSignal<number>()
    const [perPage, setPerPage] = createSignal<number>()
    const [totalPage, setTotalPage] = createSignal<number>()
    const [currentPost, setCurrentPost] = createSignal<Post>()

    function getPosts(page: number, perPage: number = 25) {
        setState(DiscoverPageState.LOADING_POSTS)

        pb
            .collection("posts")
            .getList<Post>(page, perPage)
            .then(res => {
                setTotalPage(res.totalPages)
                setCurrPage(res.page)
                setCurrentPost(res.items[0])
                setPerPage(res.perPage)
                setPosts(res.items)

                setState(DiscoverPageState.LOADED_POSTS)
            }
        )
    }

    onMount(() => {
        getPosts(1, 3);
    })

    return (
        <div class="m-4 flex flex-col space-y-4 h-screen">
            <div id="search-row" class="w-full border-2 border-black h-fit rounded-full p-2 flex space-x-2 items-center">
                <button 
                    id="leading-icon" 
                    class="bg-orange-200 p-2 rounded-full w-fit border-2 border-black"
                    onClick={() => {}}
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
            <div id="pagination-row" class="flex space-y-2 justify-center w-full">
                <div id="pagination-item" class="p-4 rounded-full border-2 border-black flex space-x-2 w-3/5 justify-center items-center">
                    <div class="flex space-x-2">
                        <button class="rounded-full" onClick={() => {
                            getPosts(1, perPage())
                        }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M18.75 19.5l-7.5-7.5 7.5-7.5m-6 15L5.25 12l7.5-7.5" /> 
                            </svg>
                        </button>
                        <button class="" onClick={() => {
                            if (currPage()) {
                                getPosts(currPage() as number - 1, perPage())
                            }
                        }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 9l-3 3m0 0l3 3m-3-3h7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /> 
                            </svg>
                        </button>
                    </div>
                    <div id="curr-page" class="">
                        {
                            currPage() && perPage() && totalPage() ?
                                <>{ currPage() } - { (perPage() as number) } of { (totalPage() as number) * (perPage() as number) } </>
                            : <></>
                        }
                    </div>
                    <div class="flex space-x-2">
                        <button class="" onClick={() => {
                            if (currPage()) {
                                getPosts(currPage() as number + 1, perPage())
                            }
                        }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12.75 15l3-3m0 0l-3-3m3 3h-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /> 
                            </svg>
                        </button>
                        <button class="" onClick={() => {
                            if (totalPage()) {
                                getPosts(totalPage() as number, perPage())
                            }
                        }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 4.5l7.5 7.5-7.5 7.5m-6-15l7.5 7.5-7.5 7.5" /> 
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    )
}