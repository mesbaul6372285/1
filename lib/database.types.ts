export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      members: {
        Row: {
          id: string
          role: 'GUEST' | 'MEMBER' | 'ADMIN'
          status: 'PENDING' | 'APPROVED' | 'REJECTED'
          joined_date: string
          name: string
          father_name: string
          mother_name: string
          present_address: string
          permanent_address: string
          birth_cert_no: string
          dob: string
          blood_group: string
          class: string
          roll: string
          mobile: string
          password: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          role?: 'GUEST' | 'MEMBER' | 'ADMIN'
          status?: 'PENDING' | 'APPROVED' | 'REJECTED'
          joined_date?: string
          name: string
          father_name: string
          mother_name: string
          present_address: string
          permanent_address: string
          birth_cert_no: string
          dob: string
          blood_group: string
          class: string
          roll: string
          mobile: string
          password: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          role?: 'GUEST' | 'MEMBER' | 'ADMIN'
          status?: 'PENDING' | 'APPROVED' | 'REJECTED'
          joined_date?: string
          name?: string
          father_name?: string
          mother_name?: string
          present_address?: string
          permanent_address?: string
          birth_cert_no?: string
          dob?: string
          blood_group?: string
          class?: string
          roll?: string
          mobile?: string
          password?: string
          created_at?: string
          updated_at?: string
        }
      }
      projects: {
        Row: {
          id: number
          title: string
          status: 'COMPLETED' | 'ONGOING' | 'UPCOMING'
          image: string
          researchers: string[]
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: number
          title: string
          status: 'COMPLETED' | 'ONGOING' | 'UPCOMING'
          image: string
          researchers: string[]
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: number
          title?: string
          status?: 'COMPLETED' | 'ONGOING' | 'UPCOMING'
          image?: string
          researchers?: string[]
          description?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      announcements: {
        Row: {
          id: number
          date: string
          title: string
          description: string
          type: 'PUBLIC' | 'INTERNAL'
          priority: 'HIGH' | 'NORMAL' | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: number
          date: string
          title: string
          description: string
          type: 'PUBLIC' | 'INTERNAL'
          priority?: 'HIGH' | 'NORMAL' | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: number
          date?: string
          title?: string
          description?: string
          type?: 'PUBLIC' | 'INTERNAL'
          priority?: 'HIGH' | 'NORMAL' | null
          created_at?: string
          updated_at?: string
        }
      }
      gallery: {
        Row: {
          id: number
          title: string
          category: 'Event' | 'Experiment' | 'Competition'
          image: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: number
          title: string
          category: 'Event' | 'Experiment' | 'Competition'
          image: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: number
          title?: string
          category?: 'Event' | 'Experiment' | 'Competition'
          image?: string
          created_at?: string
          updated_at?: string
        }
      }
      weekly_fact: {
        Row: {
          id: number
          title: string
          content: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: number
          title: string
          content: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: number
          title?: string
          content?: string
          created_at?: string
          updated_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}
