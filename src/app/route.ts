import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function GET() {

  const likeNames = ["1", "2"];
  const orConditions = likeNames.map((name) => `likes.cs.${JSON.stringify([{ like_name: name }])}`).join(",");

  const supabase = createClient();
  const payload = supabase
  .from("users_likes_view")
  .select("")
  .or(orConditions)

  const { data, error } = await payload;

  if (error) {
    console.error("Error:", error);
    return NextResponse.json({ error }, { status: 500 });
  } else {
    console.log("Data:", data);
  }

  return NextResponse.json({ data }, { status: 200 });
}
