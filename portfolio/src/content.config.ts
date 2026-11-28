import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const projects = defineCollection({
  loader: glob({ pattern: '**/*.mdx', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    stack: z.array(z.string()),
    github: z.string().url().optional(),
    demo: z.string().url().optional(),
    featured: z.boolean().default(false),
    order: z.number().default(100),
    // Years of substantive work (first and last non-maintenance commit).
    // Omit `ended` for a project that is still running.
    started: z.number().int().min(2000),
    ended: z.number().int().min(2000).optional(),
    // People who committed to the repo; 1 means a solo build.
    team: z.number().int().min(1).default(1),
    // Optional product gallery, stored under portfolio/public/ (path relative
    // to it). Rendered collapsed behind a toggle as a lazy-loaded masonry
    // grid; renders nothing when the list is empty.
    gallery: z
      .array(
        z.object({
          src: z.string(),
          alt: z.string(),
          width: z.number().int().optional(),
          height: z.number().int().optional(),
        }),
      )
      .optional(),
    // One or two sentences: what was annoying enough to build this.
    problem: z.string(),
    diagram: z.string().optional(),
  }),
});

export const collections = { projects };
