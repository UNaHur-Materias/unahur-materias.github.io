import { defineCollection, z } from 'astro:content';

// Esquema para el archivo raíz de la materia (cursada)
const cursadaSchema = z.object({
    title: z.string(),
    active: z.boolean().optional().default(true),
    comisiones: z.array(z.string()).optional(),
    dias: z.string().optional(),
    anio: z.number().optional(),
    cuatrimestre: z.string().optional(),
    docentes: z.array(z.string()).optional(),
    docentesGithub: z.array(z.string()).optional(),
    alumnosHabilitados: z.array(z.string()).optional(),
});

// Esquema para las asignaciones individuales e historial (.md internos)
const asignacionInternaSchema = z.object({
    title: z.string(),
    active: z.boolean().optional().default(true),
    fechaPublicacion: z.union([z.string(), z.date()]).optional(),
    ejercicios: z.array(z.object({
        name: z.string(),
        urlTemplate: z.string().optional(),
        destOrg: z.string().optional(),
        type: z.string().optional(),
        obligatorio: z.boolean().optional(),
        comentarios: z.array(z.object({ name: z.string() })).optional(),
        isPrivate: z.boolean().optional(),
        prefix: z.string().optional(),
        requireTOTP: z.boolean().optional(),
    })).optional(),
});

// La colección materias ahora acepta AMBOS formatos de archivos sin romper TypeScript
const materiasCollection = defineCollection({
    type: 'content',
    schema: z.union([cursadaSchema, asignacionInternaSchema])
});

const asignacionesCollection = defineCollection({
    type: 'content',
    schema: z.object({
        title: z.string(),
        ejercicios: z.array(z.any()).optional(),
    })
});

const historialCollection = defineCollection({
    type: 'content',
    schema: z.object({
        title: z.string(),
        ejercicios: z.array(z.any()).optional(),
    })
});

export const collections = {
    materias: materiasCollection,
    asignaciones: asignacionesCollection,
    historial: historialCollection,
};