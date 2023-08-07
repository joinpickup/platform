import { createClient } from "@supabase/supabase-js"

const supabaseUrl = 'https://ataobmardztjhfbslnpb.supabase.co'
const supabaseKey = import.meta.env.PUBLIC_SUPABASE_KEY as string
export const supabase = createClient(supabaseUrl, supabaseKey)